Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270279AbRIAKck>; Sat, 1 Sep 2001 06:32:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270274AbRIAKcb>; Sat, 1 Sep 2001 06:32:31 -0400
Received: from krusty.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:55310 "HELO
	krusty.e-technik.uni-dortmund.de") by vger.kernel.org with SMTP
	id <S270266AbRIAKcX>; Sat, 1 Sep 2001 06:32:23 -0400
Date: Sat, 1 Sep 2001 12:32:38 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Jeremiah Johnson <miah@netcis.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.9 UDP broke?
Message-ID: <20010901123238.C6174@emma1.>
Mail-Followup-To: Jeremiah Johnson <miah@netcis.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <8477538250.20010830232007@netcis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8477538250.20010830232007@netcis.com>; from miah@netcis.com on Thu, Aug 30, 2001 at 11:20:07PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Aug 2001, Jeremiah Johnson wrote:

>   I am having very strange problems with 2.4.9 and UDP.  Basically,
>   anything using UDP wont work.  Anything using TCP/ICMP works fine.

NTP (which relies on UDP traffic to port #123) works fine here with
2.4.9. Check your packet filter setup, please.
