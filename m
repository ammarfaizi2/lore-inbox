Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268463AbUILQsA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268463AbUILQsA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Sep 2004 12:48:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268730AbUILQsA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Sep 2004 12:48:00 -0400
Received: from elektroni.ee.tut.fi ([130.230.131.11]:13709 "HELO
	elektroni.ee.tut.fi") by vger.kernel.org with SMTP id S268463AbUILQr6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Sep 2004 12:47:58 -0400
Date: Sun, 12 Sep 2004 19:47:57 +0300
From: Petri Kaukasoina <kaukasoi@elektroni.ee.tut.fi>
To: Wolfpaw - Dale Corse <admin@wolfpaw.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.27 SECURITY BUG - TCP Local and REMOTE(verified) Denial of Service Attack
Message-ID: <20040912164757.GA947@elektroni.ee.tut.fi>
Mail-Followup-To: Wolfpaw - Dale Corse <admin@wolfpaw.net>,
	linux-kernel@vger.kernel.org
References: <029201c498d8$dff156f0$0300a8c0@s> <001c01c498df$8d2cd0f0$0200a8c0@wolf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001c01c498df$8d2cd0f0$0200a8c0@wolf>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 12, 2004 at 09:45:38AM -0600, Wolfpaw - Dale Corse wrote:
>  No problem :) I run the following, against SSH as the target, and I
> can also kill it. (using telnet as the other side of the attack)
> 
> root@maximus:/home/admin# telnet XXXXXXXXXXXXXXX 22
> Trying XXXXXXXXXXXXXX...
> Connected to XXXXXXXXXXXXXXXXX.
> Escape character is '^]'.
> Connection closed by foreign host.
> root@maximus:/home/admin# 

> Now.. Do you really want me to post the source code for it? 

With default sshd_config you can DOS sshd trivially by opening ten
connections using ten times "telnet XXXXXXXXXXXXXXX 22".
