Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261552AbVDNQ4h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261552AbVDNQ4h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 12:56:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVDNQzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 12:55:37 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:12303 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S261544AbVDNQzV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 12:55:21 -0400
Date: Thu, 14 Apr 2005 18:55:35 +0200
From: Tomasz Torcz <zdzichu@irc.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: poor SATA performance under 2.6.11 (with < 2.6.11 is OK)?
Message-ID: <20050414165535.GA15440@irc.pl>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <425E9902.8000804@interia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <425E9902.8000804@interia.pl>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2005 at 06:23:30PM +0200, Tomasz Chmielewski wrote:
> I have a Silicon Image SIL3112A SATA PCI controller + 2x 200GB, 8MB
> Barracuda drives.

 Bad combination.
 
> The performance under 2.6 kernels is *very* poor (Timing buffered disk
> reads never more than 20 MB/sec); under 2.4 it runs quite fine (Timing
> buffered disk reads around 60 MB/sec).

 2.4 risk data corruption. 2.6 sata_sil.c contains blacklist for some
driver-controller combination.

 See: http://home-tj.org/m15w/

-- 
Tomasz Torcz                        To co nierealne - tutaj jest normalne.
zdzichu@irc.-nie.spam-.pl          Ziomale na ¿ycie maj± tu patenty specjalne.

