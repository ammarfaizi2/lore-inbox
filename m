Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262009AbUDSUPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 16:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbUDSUPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 16:15:39 -0400
Received: from wsip-68-14-253-125.ph.ph.cox.net ([68.14.253.125]:46499 "EHLO
	office.labsysgrp.com") by vger.kernel.org with ESMTP
	id S262009AbUDSUPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 16:15:33 -0400
Message-ID: <40843363.4070903@backtobasicsmgmt.com>
Date: Mon, 19 Apr 2004 13:15:31 -0700
From: "Kevin P. Fleming" <kpfleming@backtobasicsmgmt.com>
Organization: Back To Basics Network Management
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jose Luis Domingo Lopez <linux-kernel@24x7linux.com>
CC: John Pesce <pescej@sprl.db.erau.edu>, linux-kernel@vger.kernel.org
Subject: Re: How to make Linux route multicast traffic bi-directionly between
 multible subnets
References: <1082389059.1982.15.camel@inferno> <20040419200739.GA3020@localhost>
In-Reply-To: <20040419200739.GA3020@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Luis Domingo Lopez wrote:

> So, to summarize, your best bet is to get "mrouted" or something like
> that, and have a look at the documentation bundled. You are quite right,
> multicast routing documentation for Linux seems to be quite old, rather
> short, and maybe out of date.

That it is, but if you use the mrouted source and patches from the 
Debian distribution it's fairly easy to get a basic network working. It 
took me a few days to get it all set up, but I now have a router that 
routes multicast between local devices and two remotes over OpenVPN 
tunnels. Setting up mrouted was actually pretty easy, once I figured out 
that's what I needed and got the Debian patches so it would compile.
