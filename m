Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278629AbRJXQEX>; Wed, 24 Oct 2001 12:04:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278633AbRJXQEN>; Wed, 24 Oct 2001 12:04:13 -0400
Received: from sith.mimuw.edu.pl ([193.0.97.1]:3334 "EHLO sith.mimuw.edu.pl")
	by vger.kernel.org with ESMTP id <S278629AbRJXQDz>;
	Wed, 24 Oct 2001 12:03:55 -0400
Date: Wed, 24 Oct 2001 18:04:14 +0200
From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
To: "David S. Miller" <davem@redhat.com>
Cc: jgarzik@mandrakesoft.com, linux-kernel@vger.kernel.org
Subject: Re: acenic breakage in 2.4.13-pre
Message-ID: <20011024180414.A16921@sith.mimuw.edu.pl>
Mail-Followup-To: Jan Rekorajski <baggins@sith.mimuw.edu.pl>,
	"David S. Miller" <davem@redhat.com>, jgarzik@mandrakesoft.com,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20011024.082925.68578636.davem@redhat.com>
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux 2.4.7 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001, David S. Miller wrote:

>    From: Jan Rekorajski <baggins@sith.mimuw.edu.pl>
>    Date: Wed, 24 Oct 2001 16:45:33 +0200
>    
>    Speaking of acenic - it's broken in 2.4.13-pre. I have 3c985 and all I
>    get with 2.4.13-pre is "Firmware NOT running!". After I backed the
>    changes from -pre patch it started and works fine. Maybe the problem is
>    I have it in 32bit PCI slot?
> 
> Do you have CONFIG_HIGHMEM enabled?  If so, please try with
> it turned off.

Nope. No HIGHMEM here.

Jan
-- 
Jan Rêkorajski            |  ALL SUSPECTS ARE GUILTY. PERIOD!
baggins<at>mimuw.edu.pl   |  OTHERWISE THEY WOULDN'T BE SUSPECTS, WOULD THEY?
BOFH, MANIAC              |                   -- TROOPS by Kevin Rubio
