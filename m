Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263584AbUACQpM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 11:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263595AbUACQpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 11:45:12 -0500
Received: from postman2.arcor-online.net ([151.189.0.188]:5083 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S263584AbUACQpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 11:45:09 -0500
Date: Sat, 3 Jan 2004 17:40:26 +0100
From: Juergen Quade <quade@hs-niederrhein.de>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: module_param( byte ... ) missing?
Message-ID: <20040103164026.GA29962@hsnr.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rusty,

using the "byte"-datatype as module parameter throws a compile error.
Other than stated in the comment of the headerfile <linux/moduleparam.h>

	/* Helper functions: type is byte, short, ushort, int, uint, long,
	   ulong, charp, bool or invbool, or XXX if you define param_get_XXX,
	   param_set_XXX and param_check_XXX. */
	#define module_param_named(name, value, type, perm)
	...
	
the datatype _byte_ seems not be implemented.
Have you dropped it intentionally?

      Juergen.

