Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSGRG7m>; Thu, 18 Jul 2002 02:59:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316576AbSGRG7l>; Thu, 18 Jul 2002 02:59:41 -0400
Received: from smtp-out-6.wanadoo.fr ([193.252.19.25]:63441 "EHLO
	mel-rto6.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S316541AbSGRG7k>; Thu, 18 Jul 2002 02:59:40 -0400
Content-Type: text/plain; charset=US-ASCII
From: Duncan Sands <duncan.sands@math.u-psud.fr>
To: "Pierre ROUSSELET" <pierre.rousselet@wanadoo.fr>, <greg@kroah.com>
Subject: Re: 2.5.25  uhci-hcd  very bad
Date: Thu, 18 Jul 2002 09:02:32 +0200
User-Agent: KMail/1.4.2
Cc: <linux-kernel@vger.kernel.org>
References: <3D308A30.7070702@wanadoo.fr> <200207180810.13692.duncan.sands@math.u-psud.fr> <3D2A791A004BDA8F@mel-rta9.wanadoo.fr> (added by     postmaster@wanadoo.fr)
In-Reply-To: <3D2A791A004BDA8F@mel-rta9.wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207180902.32023.duncan.sands@math.u-psud.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In answer to the question, "is your kernel preemptive":

On Thursday 18 July 2002 09:37, Pierre ROUSSELET wrote:
> Yes it is.

Well, the original module code contains several races.  I spent
some time cleaning these up (because it would sometimes oops
on a preemptive system), until I cracked and went over to the user
space driver...  But maybe you are not using the original code?

All the best,

Duncan.
