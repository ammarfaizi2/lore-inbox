Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422829AbWJXXfa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422829AbWJXXfa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 19:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422830AbWJXXfa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 19:35:30 -0400
Received: from michelle.lostinspace.de ([62.146.248.226]:63481 "EHLO
	michelle.lostinspace.de") by vger.kernel.org with ESMTP
	id S1422829AbWJXXf3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 19:35:29 -0400
Message-ID: <453EA343.2080504@fechner.net>
Date: Wed, 25 Oct 2006 01:35:31 +0200
From: Matthias Fechner <idefix@fechner.net>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Link lib to a kernel module
References: <20061024105518.GA55219@server.idefix.loc> <453DF507.8050101@innomedia.soft.net>
In-Reply-To: <453DF507.8050101@innomedia.soft.net>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
X-Spam_score: -4.3
X-Spam_score_int: -42
X-Spam_bar: ----
X-Spam_host: idefix.fechner.net
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-2.0.2 (michelle.lostinspace.de [62.146.248.226]); Wed, 25 Oct 2006 01:35:26 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Dipti Ranjan Tarai schrieb:
>   As per my knowledge kernel module can not access to a library
> function. Library function are only accessible to user level program.
> Module can access exported symbol only.

I don't want to build the module against a shared lib. I have here a lib
and I want that the lib is included into the kernel module.
I found in the documentation that it is possible to link the kernel
module with several object files (.o) and I found no source to do it
with libs (.a).

Thx
Matthias

-- 

"Programming today is a race between software engineers striving to
build bigger and better idiot-proof programs, and the universe trying to
produce bigger and better idiots. So far, the universe is winning." --
Rich Cook
