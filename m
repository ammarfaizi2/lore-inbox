Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbTAVSEE>; Wed, 22 Jan 2003 13:04:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262380AbTAVSEE>; Wed, 22 Jan 2003 13:04:04 -0500
Received: from holomorphy.com ([66.224.33.161]:22163 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262289AbTAVSEE>;
	Wed, 22 Jan 2003 13:04:04 -0500
Date: Wed, 22 Jan 2003 10:13:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: axboe@suse.de, cdwrite@other.debian.org, greg@ulima.unil.ch,
       linux-kernel@vger.kernel.org
Subject: Re: Can't burn DVD under 2.5.59 with ide-cd
Message-ID: <20030122181301.GQ780@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Joerg Schilling <schilling@fokus.fraunhofer.de>, axboe@suse.de,
	cdwrite@other.debian.org, greg@ulima.unil.ch,
	linux-kernel@vger.kernel.org
References: <200301220823.h0M8NG2o022692@burner.fokus.gmd.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301220823.h0M8NG2o022692@burner.fokus.gmd.de>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 22, 2003 at 09:23:16AM +0100, Joerg Schilling wrote:
> I thought it's obvious: It is most likely a problem caused by the broken 
> bit #defines in the Linux kernel for the SCSI status byte. I assume that
> status should be 0x02 instead of 0x01. In addition, I would guess that
> for the same reason, a kernel instance did not fetch the sense data as
> libscg should try to work around these Linux bugs if at least the first 
> sense byte is != 0.

I should try to cut SCSI CD's with the fixes for this stuff; sounds like
it'd affect generic SCSI I/O.

Thanks.

-- wli
