Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279421AbRJ2UDT>; Mon, 29 Oct 2001 15:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279424AbRJ2UDJ>; Mon, 29 Oct 2001 15:03:09 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:27653 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S279421AbRJ2UC7>; Mon, 29 Oct 2001 15:02:59 -0500
Date: Mon, 29 Oct 2001 21:03:33 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac4
Message-ID: <20011029210333.A4828@suse.cz>
In-Reply-To: <20011028204003.A1640@lightning.swansea.linux.org.uk> <Pine.GSO.3.96.1011029170323.3407F-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.3.96.1011029170323.3407F-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Oct 29, 2001 at 05:07:51PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 05:07:51PM +0100, Maciej W. Rozycki wrote:
> On Sun, 28 Oct 2001, Alan Cox wrote:
> 
> > o	Handle chipsets that dont get 8254 latches	(Roberto Biancardi)
> > 	right and trigger the VIA warning in error
> 
>  Hmm, has anyone tried using the "read back" 8254 command for latching,
> instead?  Chances are it's less buggy... 

We can try, but I think that it's more likely to be more buggy, because
it isn't widely used by software. And at least according to the 8254
docs they should be equivalent in what they do.

-- 
Vojtech Pavlik
SuSE Labs
