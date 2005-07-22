Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262194AbVGVVZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262194AbVGVVZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:25:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVGVVZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:25:56 -0400
Received: from outpost.ds9a.nl ([213.244.168.210]:22719 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id S262185AbVGVVZl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:25:41 -0400
Date: Fri, 22 Jul 2005 23:24:54 +0200
From: bert hubert <bert.hubert@netherlabs.nl>
To: Davy Durham <pubaddr2@davyandbeth.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: select() efficiency
Message-ID: <20050722212454.GB18988@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <bert.hubert@netherlabs.nl>,
	Davy Durham <pubaddr2@davyandbeth.com>, linux-kernel@vger.kernel.org
References: <42E162B6.2000602@davyandbeth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E162B6.2000602@davyandbeth.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 22, 2005 at 04:18:46PM -0500, Davy Durham wrote:
> Please forgive and redirect me if this is not the right place to ask 
> this question:
> 
> I'm looking to write a sort of messaging system that would take input 
> from any number of entities that "register" with it.. it would then 
> route the messages to outputs and so forth..

Look at epoll, or libevent, which uses epoll to be quick in this scenario.


-- 
http://www.PowerDNS.com      Open source, database driven DNS Software 
http://netherlabs.nl              Open and Closed source services
