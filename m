Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264573AbTKNSBp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Nov 2003 13:01:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264576AbTKNSBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Nov 2003 13:01:45 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:44816
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264573AbTKNSBo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Nov 2003 13:01:44 -0500
Subject: Re: Adding Deprecated Attribute Tags
From: Robert Love <rml@tech9.net>
To: "Joseph D. Wagner" <theman@josephdwagner.info>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200311132218.57222.theman@josephdwagner.info>
References: <200311132218.57222.theman@josephdwagner.info>
Content-Type: text/plain
Message-Id: <1068832904.2860.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 14 Nov 2003 13:01:44 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-11-13 at 11:18, Joseph D. Wagner wrote:

> This will aid future development and debugging to ensure that everyone uses 
> the new struct ext2_dir_entry_2 and can take advantage of the additional 
> fields.

We have a special __deprecated define in include/compiler.h and family
to safely mark this (e.g., it defines away on older gcc's and Intel's
CC).

	Robert Love


