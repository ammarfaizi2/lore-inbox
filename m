Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136365AbREDMgx>; Fri, 4 May 2001 08:36:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136354AbREDMgn>; Fri, 4 May 2001 08:36:43 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:31251 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S136348AbREDMga>;
	Fri, 4 May 2001 08:36:30 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Nico Schottelius <nicos@pcsystems.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: added a new feature: disable pc speaker 
In-Reply-To: Your message of "Fri, 04 May 2001 13:37:08 +0200."
             <3AF29464.885B7F13@pcsystems.de> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 04 May 2001 22:36:24 +1000
Message-ID: <8340.988979784@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 04 May 2001 13:37:08 +0200, 
Nico Schottelius <nicos@pcsystems.de> wrote:
>I have searched a long time for a method to disable the internal
>speaker for every application, every daemon and so on.

Userspace problem, userspace fix.

  setterm -blength 0 (text)
  xset b 0 (X11)

