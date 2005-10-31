Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932118AbVJaKgD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932118AbVJaKgD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 05:36:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932279AbVJaKgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 05:36:02 -0500
Received: from duempel.org ([81.209.165.42]:60902 "HELO duempel.org")
	by vger.kernel.org with SMTP id S932118AbVJaKgB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 05:36:01 -0500
Date: Mon, 31 Oct 2005 11:33:27 +0100
From: Max Kellermann <max@duempel.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: 2.6.14-rc4-mm1 and later: second ata_piix controller is invisible
Message-ID: <20051031103327.GA25403@roonstrasse.net>
Mail-Followup-To: Jeff Garzik <jgarzik@pobox.com>,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
References: <20051025095646.GA24977@roonstrasse.net> <4364C3B8.1010909@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4364C3B8.1010909@pobox.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005/10/30 13:59, Jeff Garzik <jgarzik@pobox.com> wrote:
> I was able to reproduce your (Max's) problem locally, and verified
> that the attached patch fixed it.

I can confirm that.  2.6.14-rc5-mm1 plus your patch fixed my problem,
ata2 and /dev/sdb are available.

Max

