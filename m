Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261621AbSI0Dv2>; Thu, 26 Sep 2002 23:51:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261622AbSI0Dv2>; Thu, 26 Sep 2002 23:51:28 -0400
Received: from c16410.randw1.nsw.optusnet.com.au ([210.49.25.29]:31485 "EHLO
	mail.chubb.wattle.id.au") by vger.kernel.org with ESMTP
	id <S261621AbSI0Dv1>; Thu, 26 Sep 2002 23:51:27 -0400
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15763.55020.35426.721691@wombat.chubb.wattle.id.au>
Date: Fri, 27 Sep 2002 13:56:28 +1000
To: Thunder from the hill <thunder@lightweight.ods.org>
Cc: Rik van Riel <riel@conectiva.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] Single linked lists for Linux, overly complicated
 v2
In-Reply-To: <924963807@toto.iv>
X-Mailer: VM 7.04 under 21.4 (patch 8) "Honest Recruiter" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Thunder" == Thunder from the hill <thunder@lightweight.ods.org> writes:

Thunder> Hi, On Thu, 26 Sep 2002, Rik van Riel wrote:
>> Have you thought about how to _use_ a list without a list head ?

Thunder> Indeed, that was why I've brought this up at all...

What is the problem these lists are intended to solve?

There's no point in adding general infrastructure that has no
immediate uses -- it just ends up mouldering in a corner,
(like the generic hashing code linux/ghash.h which has been in the
kernel for 4 or 5 years, and still has *no* uses.)

--
Dr Peter Chubb				    peterc@gelato.unsw.edu.au
You are lost in a maze of BitKeeper repositories, all almost the same.
