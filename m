Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266961AbSLDJo1>; Wed, 4 Dec 2002 04:44:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266965AbSLDJo1>; Wed, 4 Dec 2002 04:44:27 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:18670 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S266961AbSLDJo1>; Wed, 4 Dec 2002 04:44:27 -0500
Subject: Re: PROBLEM: "kernel BUG" in syslog
From: Arjan van de Ven <arjanv@redhat.com>
To: Luke Q <lcampagn@mines.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1038990133.709.22.camel@localhost>
References: <1038990133.709.22.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Dec 2002 10:51:48 +0100
Message-Id: <1038995508.1552.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-04 at 09:22, Luke Q wrote:
> I recently had an interesting problem.. the local terminal on my
> Debian/Unstable went blank suddenly, so I headed over to my trusty music
> server to see if I could log in remotely and kill off X (which is
> usually the cause of problems like this) ..after logging in, I found
> that most commands would run alright (sudo, ls, df..) but using kill
> would freeze the terminal completely. An inspection of my kernel logs
> showed a bunch of these: 
> 
> Dec  2 23:56:02 localhost kernel: kernel BUG at page_alloc.c:102!

Nice nvidia oops..... Are you using the nvidia binary only kernel
module?
