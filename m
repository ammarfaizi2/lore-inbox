Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314287AbSDVRJ4>; Mon, 22 Apr 2002 13:09:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314288AbSDVRJz>; Mon, 22 Apr 2002 13:09:55 -0400
Received: from pc-62-31-74-87-ed.blueyonder.co.uk ([62.31.74.87]:41348 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S314287AbSDVRJy>; Mon, 22 Apr 2002 13:09:54 -0400
Date: Mon, 22 Apr 2002 18:08:15 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: "Ph. Marek" <marek@bmlv.gv.at>
Cc: sct@redhat.com, akpm@zip.com.au, adilger@turbolinux.com,
        linux-kernel@vger.kernel.org, ext3-users@redhat.com
Subject: Re: [PATCH] open files in kjounald
Message-ID: <20020422180815.F10370@redhat.com>
In-Reply-To: <3.0.6.32.20020422065639.0090cd10@pop3.bmlv.gv.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Which kernel?  I can't reproduce the problem you describe using the
2.4.18 variant I'm running right now, and the source seems to indicate
that we're already doing the right thing.  Using your reproducer
recipe, I see fd 30 being closed in all kjournald contexts.

--Stephen
