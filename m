Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264551AbTFYP2T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbTFYP2T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:28:19 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:2060 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264551AbTFYP2Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:28:16 -0400
Date: Wed, 25 Jun 2003 17:42:23 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Christoph Hellwig <hch@infradead.org>,
       Michael Hunold <hunold@convergence.de>, linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625154223.GB1333@mars.ravnborg.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>, linux-kernel@vger.kernel.org
References: <20030625150629.GA1045@mars.ravnborg.org> <20030625160830.A19958@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030625160830.A19958@infradead.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 04:08:30PM +0100, Christoph Hellwig wrote:
> On Wed, Jun 25, 2003 at 05:06:29PM +0200, Sam Ravnborg wrote:
> > hch: Please correct me if I got it wrong with respect to include files.
> 
> I don't think it makes sense to have includes outside the current directory
> if it's never used from somewhere else.  Otherwise I'd move it to
> include/linux/ (for one or two headers) or include/<subsystem>/

For the dvb case, the .h files are used by files located in:
dvb/frontends
dvb/ttpci

Therefore I suggested linux/media.

For files such as drivers/scsi/aic7xxx/* it would not make sense since
all user are in the same directory.

	Sam
