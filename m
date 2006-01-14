Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945991AbWANDLE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945991AbWANDLE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 22:11:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945992AbWANDLE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 22:11:04 -0500
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:9650 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1945991AbWANDLC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 22:11:02 -0500
Date: Fri, 13 Jan 2006 22:07:32 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] kobject: don't oops on null kobject.name
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Message-ID: <200601132209_MC3-1-B5D3-F9A8@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060113143013.0ed0f9c0.akpm@osdl.org>
References: <20060110184624.GA6721@aitel.hist.no>

On Fri, 13 Jan 2006, Andrew Morton wrote:

> Why did you choose kobject_get_path()?

This is the piece of code that was oopsing in Helge Hafting's
bug report: "2.6.15 OOPS while trying to mount cdrom".  This
patch solves that by fixing the symptoms.

Details are in that thread.
-- 
Chuck
Currently reading: _Olympos_ by Dan Simmons
