Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129593AbRB0Vgv>; Tue, 27 Feb 2001 16:36:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129679AbRB0Vgi>; Tue, 27 Feb 2001 16:36:38 -0500
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:4057 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S129593AbRB0VgV>; Tue, 27 Feb 2001 16:36:21 -0500
Date: Tue, 27 Feb 2001 21:36:13 +0000
From: Tim Waugh <twaugh@redhat.com>
To: Don Dugger <ddugger@willie.n0ano.com>
Cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, linux-kernel@vger.kernel.org
Subject: [OT] Re: binfmt_script and ^M
Message-ID: <20010227213613.Q13721@redhat.com>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F2D@ftrs1.intranet.ftr.nl> <20010227143823.A25058@cistron.nl> <20010227202059.C11060@pcep-jamie.cern.ch> <20010227125948.A26290@willie.n0ano.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010227125948.A26290@willie.n0ano.com>; from ddugger@willie.n0ano.com on Tue, Feb 27, 2001 at 12:59:48PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2001 at 12:59:48PM -0700, Don Dugger wrote:

> Isn't `perl' overkill?  Why not just:
> 
> 	tr -d '\r'

while read line; do echo ${line%?}; done
