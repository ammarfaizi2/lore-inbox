Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132692AbRDQOl0>; Tue, 17 Apr 2001 10:41:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132686AbRDQOlS>; Tue, 17 Apr 2001 10:41:18 -0400
Received: from ns.suse.de ([213.95.15.193]:11536 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S132691AbRDQOlF>;
	Tue, 17 Apr 2001 10:41:05 -0400
Date: Tue, 17 Apr 2001 16:41:03 +0200
From: Andi Kleen <ak@suse.de>
To: Jan Kasprzak <kas@informatics.muni.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible problem with zero-copy TCP and sendfile()
Message-ID: <20010417164103.A9515@gruyere.muc.suse.de>
In-Reply-To: <20010417151007.F916@informatics.muni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010417151007.F916@informatics.muni.cz>; from kas@informatics.muni.cz on Tue, Apr 17, 2001 at 03:10:07PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2001 at 03:10:07PM +0200, Jan Kasprzak wrote:
> 00:0c.0 Ethernet controller: 3Com Corporation 3c905C-TX [Fast Etherlink] (rev 74)


IIRC the problem came up earlier. Some versions of 3com NICs seem to make
problems with the hardware checksum. There were some fixes in the driver 
later; could you try it with 2.4.4pre3 (which includes zerocopy) ?


-Andi
