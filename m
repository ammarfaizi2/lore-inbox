Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318536AbSGaW4c>; Wed, 31 Jul 2002 18:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318538AbSGaW4c>; Wed, 31 Jul 2002 18:56:32 -0400
Received: from vitelus.com ([64.81.243.207]:24335 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S318536AbSGaW4b>;
	Wed, 31 Jul 2002 18:56:31 -0400
Date: Wed, 31 Jul 2002 15:59:54 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ATAPI CD-R lags system to hell burning in DAO mode; but not in TAO
Message-ID: <20020731225953.GA29020@vitelus.com>
References: <20020731203008.GA27702@vitelus.com> <3D48511A.C31443A3@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D48511A.C31443A3@zip.com.au>
User-Agent: Mutt/1.5.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 31, 2002 at 02:05:30PM -0700, Andrew Morton wrote:
> This is presumably because the machine is full of memory which
> is dirty against a slooow device.

I don't seem to have sysctl support in my kernel right now, so I can't
verify this until I reboot.

I did notice that both cdrdao and cdrdao set realtime scheduling
priority. I thought this would surely answer everything, but burning
as an unprivileged user causes the same interactvity (and NFS
throughput) problems as before.
