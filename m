Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261682AbTCQBSr>; Sun, 16 Mar 2003 20:18:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261685AbTCQBSr>; Sun, 16 Mar 2003 20:18:47 -0500
Received: from tudela.mad.ttd.net ([194.179.1.233]:31886 "EHLO
	tudela.mad.ttd.net") by vger.kernel.org with ESMTP
	id <S261682AbTCQBSq>; Sun, 16 Mar 2003 20:18:46 -0500
Date: Mon, 17 Mar 2003 02:28:58 +0100 (MET)
From: Javier Achirica <achirica@telefonica.net>
To: Tim Pepper <tpepper@vato.org>
cc: Thomas Hood <jdthood0@yahoo.co.uk>, <linux-kernel@vger.kernel.org>
Subject: Re: Cisco Aironet 340 oops with 2.4.20
In-Reply-To: <20030316163358.A25887@jose.vato.org>
Message-ID: <Pine.SOL.4.30.0303170227020.6371-100000@tudela.mad.ttd.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm aware of this "lock up" problem. I was hoping it was a locking issue
and the last changes would solve it. Looks like not. The biggest problem
I'm having with that issue is that I'm not able to reproduce it. Any
suggestion?

Javier Achirica

On Sun, 16 Mar 2003, Tim Pepper wrote:

> I've got a caveat to my previously posted 'works for me'.  Before I'd
> notice that my net connection was no longer moving and then see the oops
> in my log if I looked.	With the cvs driver I still tend to see that my
> net connection dies sometimes, but no oops.  I've found hotplugging the pcmcia
> card brings it back to life.
>
> It seems like I hit this with either driver primarily if I've put my
> laptop to sleep earlier in its current uptime.  Is there possibly a
> deadlock somewhere around the previously oopsing code and/or the airo_cs
> interaction with apm?
>
> t.
> --
> *********************************************************
> *  tpepper@vato dot org             * Venimus, Vidimus, *
> *  http://www.vato.org/~tpepper     * Dolavimus         *
> *********************************************************
>
>
>

