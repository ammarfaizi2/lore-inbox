Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265052AbTLRJ7G (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 04:59:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265056AbTLRJ7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 04:59:06 -0500
Received: from adsl-65-66-18-161.dsl.okcyok.swbell.net ([65.66.18.161]:40408
	"EHLO teco-xaco.com") by vger.kernel.org with ESMTP id S265052AbTLRJ7E
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 04:59:04 -0500
Message-ID: <3FE179AE.6030409@teco-xaco.com>
Date: Thu, 18 Dec 2003 03:55:58 -0600
From: Daniel Newby <newby@teco-xaco.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
References: <1071738720.25032.496.camel@otter.zagar.linux-dude.net>
In-Reply-To: <1071738720.25032.496.camel@otter.zagar.linux-dude.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy Zagar wrote:
[snip]
> The question boils down to this:
> 
> For a header file, does anything truly worthy of copyright 
> actually survive the compilation process?
[snip]

Yes:  inline functions, unless you're careful about which headers 
you use and how you use them. And you have to be very, very careful 
because which symbols turn into inline functions depends on which 
kernel options are selected, which architecture you're building for, 
minor variations between kernel versions, the phase of the moon, 
etc.  It would take tainting support in gcc itself, and that isn't 
like to happen for a variety of practical and political reasons.

     -- Daniel Newby

