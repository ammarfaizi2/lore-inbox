Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269958AbRHENdI>; Sun, 5 Aug 2001 09:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269959AbRHENc6>; Sun, 5 Aug 2001 09:32:58 -0400
Received: from dfmail.f-secure.com ([194.252.6.39]:5636 "HELO
	dfmail.f-secure.com") by vger.kernel.org with SMTP
	id <S269958AbRHENcz>; Sun, 5 Aug 2001 09:32:55 -0400
Date: Sun, 5 Aug 2001 16:46:21 +0300 (MET DST)
From: Szabolcs Szakacsits <szaka@f-secure.com>
To: <kern@wolf.ericsson.net.nz>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Oops pcnet32 ethernet driver on Compaq Deskpro 5100
In-Reply-To: <Pine.LNX.4.33.0108041641480.14017-100000@wolf.ericsson.net.nz>
Message-ID: <Pine.LNX.4.30.0108051626260.29834-100000@fs131-224.f-secure.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 4 Aug 2001 kern@wolf.ericsson.net.nz wrote:

> I am getting the following oops when I try to insert the pcnet32 ethernet
> driver on an older Compaq 5100 (Pentium 100 with onboard ethernet
> controller) and rh7.1

Get the RH 7.1 kernel update
	http://www.redhat.com/support/errata/RHSA-2001-084.html
or upgrade your kernel to a recent one. You have an old pcnet32 card
that needs 16 bit init first but some early 2.4 (and the RH 7.1 shipped)
kernel did 32 bit init.

	Szaka

