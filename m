Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262262AbSIZJQz>; Thu, 26 Sep 2002 05:16:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262263AbSIZJQz>; Thu, 26 Sep 2002 05:16:55 -0400
Received: from danielle.hinet.hr ([195.29.148.143]:51594 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S262262AbSIZJQx>; Thu, 26 Sep 2002 05:16:53 -0400
Date: Thu, 26 Sep 2002 11:21:52 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: Michael Clark <michael@metaparadigm.com>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa4 OOPS in ext3 (get_hash_table,  unmap_underlying_metadata)
Message-ID: <20020926092152.GA32593@danielle.hinet.hr>
References: <3D92A1D0.5000203@metaparadigm.com> <3D92B6F3.1428A76A@digeo.com> <3D92BDC8.8080603@metaparadigm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3D92BDC8.8080603@metaparadigm.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

slightly trimmed,

On Thu, Sep 26, 2002 at 03:56:56PM +0800, Michael Clark wrote:
> On 09/26/02 15:27, Andrew Morton wrote:
> 
> >People are saying unkind things about the qlogic driver, and
> 
> Yes i know. My experience seems to be bad fault recovery after
> a LIP reset although the driver in 2.4.19pre10aa4 seems okay
> (have tested loop interruption under IO heavy load).
> 
> >the new version in Andrea's latest patchset is definitely
> >faster than before.   Might be worth a shot.
> 
> So, is possible for qlogic driver to be doing naughty things
> with bufferheads? or is it more likely in the fs?
> 
> Anyone out there running a reasonably busy fileserver with
> qlogic FC HBA and using ext3 or XFS with quotas? What
> kernel/qlogic driver combo?

# w
 11:06am  up 159 days, 12:01,  1 user,  load average: 4.22, 3.41, 3.53
# uname -r
2.4.18

ext3 partition on SAN connected through _two_ qla2200 HBAs and onto _two_
FC switches with qla2200phase1.tar.gz driver from Arjan van de Ven.
(the _only_ driver that works with MULTIPATH)


-- 
Mario Mikoèeviæ (Mozgy)
mozgy at hinet dot hr
My favourite FUBAR ...
