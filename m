Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266597AbUBDVEV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266534AbUBDVCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:02:48 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:11488 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S266599AbUBDU5w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 15:57:52 -0500
Subject: Re: [Bug 2013] New: Oops from create_dir (sysfs)
From: John Rose <johnrose@austin.ibm.com>
To: Greg KH <greg@kroah.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20040204204811.GA3992@us.ibm.com>
References: <1075926442.3026.37.camel@verve>
	 <20040204204811.GA3992@us.ibm.com>
Content-Type: text/plain
Message-Id: <1075928072.3026.47.camel@verve>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 04 Feb 2004 14:54:32 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The kobject code quickly pointed out the flaw in your code.  

That it did, but an "already exists" return code from kobject_add would
have pointed it out more quickly :)

John


