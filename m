Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313821AbSDIIae>; Tue, 9 Apr 2002 04:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313822AbSDIIad>; Tue, 9 Apr 2002 04:30:33 -0400
Received: from velli.mail.jippii.net ([195.197.172.114]:38059 "HELO
	velli.mail.jippii.net") by vger.kernel.org with SMTP
	id <S313821AbSDIIac>; Tue, 9 Apr 2002 04:30:32 -0400
Date: Tue, 9 Apr 2002 11:32:43 +0300
From: Anssi Saari <as@sci.fi>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROMBLEM: CD burning at 16x uses excessive CPU, although DMA is enabled
Message-ID: <20020409083243.GB23043@sci.fi>
In-Reply-To: <20020408122603.GA7877@sci.fi> <Pine.LNX.3.96.1020408104857.21476C-100000@gatekeeper.tmr.com> <20020408174529.A546@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 08, 2002 at 05:45:29PM -0400, Mark Mielke wrote:
 
> The question is, how is CD burning of raw data different from
> CD burning of ISO images, in respect to Linux drivers for the
> hardware

As far as I know, when burning an ISO image, the image has 2048 byte
sectors to which the CD writer adds error correction data so that the
individual sector becomes 2352 bytes. A raw data image includes 2352 byte
sectors. The obvious difference would be a higher data rate (2352/2048
or 1.15x more) from computer to writer. 

