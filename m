Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262861AbTFDFRp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 01:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262874AbTFDFRp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 01:17:45 -0400
Received: from [204.94.215.101] ([204.94.215.101]:60351 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S262861AbTFDFRo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 01:17:44 -0400
X-Mailer: exmh version 2.5 01/15/2001 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Daniel.A.Christian@NASA.gov
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21-rc7 SMP module unresolved symbols 
In-reply-to: Your message of "Tue, 03 Jun 2003 17:28:41 MST."
             <200306031728.41982.Daniel.A.Christian@NASA.gov> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 04 Jun 2003 15:30:52 +1000
Message-ID: <2029.1054704652@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jun 2003 17:28:41 -0700, 
Dan Christian <Daniel.A.Christian@NASA.gov> wrote:
>I can build a 2.4.21-rc7 Athlon single processor kernel and modules 
>without problem.
>
>When I enable SMP, most (but not all) modules have unresolved symbols.  

On 2.4 kernels, you must make mrproper when switching between SMP and
UP.

