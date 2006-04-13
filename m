Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751200AbWDMIj3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751200AbWDMIj3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 04:39:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWDMIj2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 04:39:28 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:35298 "HELO
	ilport.com.ua") by vger.kernel.org with SMTP id S964829AbWDMIj1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 04:39:27 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Dave Dillow <dave@thedillows.org>
Subject: Re: [RFD][PATCH] typhoon and core sample for folding away VLAN stuff
Date: Thu, 13 Apr 2006 11:38:59 +0300
User-Agent: KMail/1.8.2
Cc: Ingo Oeser <ioe-lkml@rameria.de>, Ingo Oeser <netdev@axxeo.de>,
       netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
       linux-kernel@vger.kernel.org, jgarzik@pobox.com
References: <200604071628.30486.vda@ilport.com.ua> <200604122132.46113.ioe-lkml@rameria.de> <443DA830.8030209@thedillows.org>
In-Reply-To: <443DA830.8030209@thedillows.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604131138.59611.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 April 2006 04:24, Dave Dillow wrote:
> Regardless, I remain opposed to this particular instance of bloat 
> busting. While both patches have improved in style, they remove a useful 
> feature and make the code less clean, for no net gain.

What happened to non-modular build? "no net gain" is not true.
 
> > This kind of changes are important, because bloat creeps in byte by byte
> > of unused features. So I really appreciate your work here Denis.
> 
> On SMP FC4, typhoon.ko has a text size of 68330, so you need to cut 2794 
> bytes to see an actual difference in memory usage for a module. Non-SMP 
> it is 67741, so there you only need to cut 2205 bytes to get a win.

This is silly. Should I go this route and try a dozen of different gcc
versions and "-O2 versus -Os" things to demonstrate that sometimes
it will matter?
--
vda
