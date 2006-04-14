Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932158AbWDNLkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932158AbWDNLkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 07:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWDNLkE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 07:40:04 -0400
Received: from mail1.webmaster.com ([216.152.64.168]:58895 "EHLO
	mail1.webmaster.com") by vger.kernel.org with ESMTP
	id S1750990AbWDNLkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 07:40:03 -0400
From: "David Schwartz" <davids@webmaster.com>
To: "David Weinehall" <tao@acc.umu.se>, <linux-kernel@vger.kernel.org>
Subject: RE: GPL issues
Date: Fri, 14 Apr 2006 04:39:56 -0700
Message-ID: <MDEHLPKNGKAHNMBLJOLKOEFKLFAB.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <fcff6ec10604120001o18ca9edxf11ed055b5601e2a@mail.gmail.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Importance: Normal
X-Authenticated-Sender: joelkatz@webmaster.com
X-Spam-Processed: mail1.webmaster.com, Fri, 14 Apr 2006 04:36:01 -0700
	(not processed: message from trusted or authenticated source)
X-MDRemoteIP: 206.171.168.138
X-Return-Path: davids@webmaster.com
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: davids@webmaster.com
X-MDAV-Processed: mail1.webmaster.com, Fri, 14 Apr 2006 04:36:02 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> An example could be helpful in clarifying the GPL license.
>
> Suppose I use the linux-vrf patch for the kernel that is freely
> available and use the extended setsocket options such as SO_VRF in an
> application, do I have to release my application under GPL since I am
> using a facility in the kernel that a standard linux kernel does not
> provide?

	Almost definitely not. Here you have two works that provide two distinctly
different functions and communicate across a well-defined boundary. In
theory, the two works could have been developed completely independently, so
one cannot be a derivative work of the other.

	The thing you need to remember is that the API that userspace uses to
communicate with the kernel is itself a work. In this case, it almost
certainly is purely functional and contains no protectable, copyrightable
content. Both the kernel changes and the user-space code take only from the
API. They do not take from each other.

	DS


