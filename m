Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316672AbSFUQQU>; Fri, 21 Jun 2002 12:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316673AbSFUQQT>; Fri, 21 Jun 2002 12:16:19 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:44419 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316672AbSFUQQS>; Fri, 21 Jun 2002 12:16:18 -0400
Date: Fri, 21 Jun 2002 17:15:50 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ville Herva <vherva@twilight.cs.hut.fi>,
       "Stephen C. Tweedie" <sct@redhat.com>,
       Daniel Phillips <phillips@bonn-fries.net>,
       Andreas Dilger <adilger@clusterfs.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>,
       ext2-devel@lists.sourceforge.net
Subject: Re: [Ext2-devel] Re: Shrinking ext3 directories
Message-ID: <20020621171550.E2805@redhat.com>
References: <Pine.LNX.4.44.0206191256550.20859-100000@localhost.localdomain> <20020620103429.A2464@redhat.com> <20020620101812.GL22427@clusterfs.com> <E17L2G0-00019Q-00@starship> <20020621145451.GA1548@niksula.cs.hut.fi> <20020621160833.D2805@redhat.com> <20020621153801.GK1465@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020621153801.GK1465@niksula.cs.hut.fi>; from vherva@niksula.hut.fi on Fri, Jun 21, 2002 at 06:38:01PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 21, 2002 at 06:38:01PM +0300, Ville Herva wrote:
 
> So I thought, but not in ext2?

It's in ext2 --- it's the i_dir_start_lookup field that remembers
where we were last.

--Stephen
