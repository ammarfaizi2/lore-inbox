Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278429AbRJMWbI>; Sat, 13 Oct 2001 18:31:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278430AbRJMWbA>; Sat, 13 Oct 2001 18:31:00 -0400
Received: from a1as13-p76.stg.tli.de ([195.252.191.76]:31665 "EHLO
	dea.linux-mips.net") by vger.kernel.org with ESMTP
	id <S278429AbRJMWau>; Sat, 13 Oct 2001 18:30:50 -0400
Date: Sun, 14 Oct 2001 00:31:14 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "J . A . Magallon" <jamagallon@able.es>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: bug in mips/config.in
Message-ID: <20011014003114.A21528@dea.linux-mips.net>
In-Reply-To: <20011013001116.G1693@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011013001116.G1693@werewolf.able.es>; from jamagallon@able.es on Sat, Oct 13, 2001 at 12:11:16AM +0200
X-Accept-Language: de,en,fr
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 12:11:16AM +0200, J . A . Magallon wrote:

> Due to a buggy bit I found in i2c, I did a
> werewolf:/usr/src/linux# grep -r "\"CONFIG" . | fgrep .in
> ./arch/mips/config.in:      if [ "CONFIG_DECSTATION" = "y" ]; then
> 
> '$' is missing there, isn't it ?

Long fixed.

  Ralf
