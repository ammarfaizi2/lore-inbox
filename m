Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265462AbRFVQcD>; Fri, 22 Jun 2001 12:32:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265463AbRFVQbw>; Fri, 22 Jun 2001 12:31:52 -0400
Received: from www.transvirtual.com ([206.14.214.140]:59402 "EHLO
	www.transvirtual.com") by vger.kernel.org with ESMTP
	id <S265462AbRFVQbm>; Fri, 22 Jun 2001 12:31:42 -0400
Date: Fri, 22 Jun 2001 09:31:26 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Romain Dolbeau <dolbeaur@club-internet.fr>
cc: linux kernel <linux-kernel@vger.kernel.org>,
        linux fbdev <Linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: [PATCH] fbgen & multiple RGBA
In-Reply-To: <3B335146.6000403@club-internet.fr>
Message-ID: <Pine.LNX.4.10.10106220926460.9835-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> the attached patch fix a problem with fbgen when changing the
> RGBA components but not the depth ; fbgen would not change
> the colormap in this case, where it should.

It would be much easier to use a memcmp.

