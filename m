Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132945AbRAPWoU>; Tue, 16 Jan 2001 17:44:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133017AbRAPWoK>; Tue, 16 Jan 2001 17:44:10 -0500
Received: from hq.fsmlabs.com ([209.155.42.197]:21779 "EHLO hq.fsmlabs.com")
	by vger.kernel.org with ESMTP id <S132945AbRAPWn4>;
	Tue, 16 Jan 2001 17:43:56 -0500
Date: Tue, 16 Jan 2001 15:41:36 -0700
From: Cort Dougan <cort@fsmlabs.com>
To: Eli Carter <eli.carter@inet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lance.c @ 100Mbit
Message-ID: <20010116154136.M28808@hq.fsmlabs.com>
In-Reply-To: <3A64CADF.17C9B9A3@inet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <3A64CADF.17C9B9A3@inet.com>; from Eli Carter on Tue, Jan 16, 2001 at 04:27:43PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

} Quick question:  has anyone used the lance.c driver for a 100BaseT
} network PCI device?  If so, what successes/failures did you run into?
} 
} (I'm working with an Am79C973 chip.)

I'd recommend the pcnet32.c driver for that chip, instead.  I was running
it for a little over a year at 100Mbps with no serious trouble.  This was
under Linux/PPC, so there were some endian-ness problems at first but it's
clean now.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
