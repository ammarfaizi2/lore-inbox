Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbTAER1V>; Sun, 5 Jan 2003 12:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbTAER1V>; Sun, 5 Jan 2003 12:27:21 -0500
Received: from aslan.scsiguy.com ([63.229.232.106]:48393 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S264908AbTAER1V>; Sun, 5 Jan 2003 12:27:21 -0500
Date: Sun, 05 Jan 2003 10:35:47 -0700
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Gregoire Favre <greg@ulima.unil.ch>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.54 problem with IDE ICH4 and aic7xxx
Message-ID: <486950000.1041788147@aslan.scsiguy.com>
In-Reply-To: <20030105165441.GA8215@ulima.unil.ch>
References: <20030105165441.GA8215@ulima.unil.ch>
X-Mailer: Mulberry/3.0.0b10 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Under 2.4.20 it boots perfectly...
> What I found really strange is the time my IDE take to boot. More than
> five minutes for thoses lines :

It's not clear from your report exactly where that delay is occurring.
Is it just before the Adaptec banner is printed or in the middle
of the IDE messages?  Does the problem persist if you disable domain
validation via SCSI-Select on your 29160?

--
Justin

