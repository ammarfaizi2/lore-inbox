Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268530AbTBNVwJ>; Fri, 14 Feb 2003 16:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268531AbTBNVwI>; Fri, 14 Feb 2003 16:52:08 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:35333 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S268530AbTBNVwH>;
	Fri, 14 Feb 2003 16:52:07 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Fri, 14 Feb 2003 14:01:55 -0800
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Accessing the same disk via multiple channels
Message-ID: <20030214140155.A5344@jose.vato.org>
Mail-Followup-To: Tim Pepper <tpepper>, Lars Marowsky-Bree <lmb@suse.de>,
	Bernd Eckenfels <ecki@calista.eckenfels.6bone.ka-ip.net>,
	linux-kernel@vger.kernel.org
References: <20030213194917.GA8479@quadpro.stupendous.org> <E18jS75-0007na-00@calista.inka.de> <20030214100316.GA3422@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030214100316.GA3422@marowsky-bree.de>; from lmb@suse.de on Fri, Feb 14, 2003 at 11:03:16AM +0100
X-PGP-Key: http://vato.org/~tpepper/pubkey.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14 Feb at 11:03:16 +0100 lmb@suse.de done said:
> 
> Doing it in the SCSI layer has the advantage of not being constrained to block
> devices, but also working with tapes. Oh well, we'll see ;-)

Tape needs special multipathing logic.  Don't you think moving
multipathing to the mid-layer requires the mid-layer to know much more
about the upper layer and muddles up the scsi stack's layering?  To keep
multipathing high and generic we need better error reporting than the
one bit that hits the md layer in 2.4...

t.
-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
