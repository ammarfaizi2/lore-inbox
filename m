Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264196AbTDPJgp (for <rfc822;willy@w.ods.org>); Wed, 16 Apr 2003 05:36:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264275AbTDPJgo 
	(for <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 05:36:44 -0400
Received: from calvin.stupendous.org ([213.84.70.4]:11019 "HELO
	quadpro.stupendous.org") by vger.kernel.org with SMTP
	id S264196AbTDPJgo (for <rfc822;linux-kernel@vger.kernel.org>); Wed, 16 Apr 2003 05:36:44 -0400
Date: Wed, 16 Apr 2003 11:48:36 +0200
From: Jurjen Oskam <jurjen@quadpro.stupendous.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Booting from Qlogic qla2300 fibre channel card
Message-ID: <20030416094836.GA31082@quadpro.stupendous.org>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030416061830.GA30423@quadpro.stupendous.org> <5.1.0.14.2.20030416162813.03b1b6e8@mira-sjcm-3.cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20030416162813.03b1b6e8@mira-sjcm-3.cisco.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 04:56:16PM +1000, Lincoln Dale wrote:

> in general, all OSes get rather upset if disks disappear under 
> them.  particularly if those disks contain swap -- exactly how is the 
> machine meant to recover from that?

Of course, if cables are pulled out or something like that, I'm not expecting
the OS to recover from that. :-)

I'm not trying to recover from or survive physical configuration changes.
I'm more interested in what happens when a volume generates a temporary
error, such as the ones that sometimes occur when doing logical
configuration changes (BIN-file changes on Symmetrix, for example).

> >When making an online configuration change on the Symmetrix (such as
> >remapping volumes), it is possible for the attached hosts to experience
> >a temporary error while accessing a storage array volume. For example,
> are you sure this tech note will still apply with the DMX?

I'm not sure, but that doesn't apply to us anyway since we have a 8530.


Anyway, I'll take a look at the SCSI_TIMEOUT value. Thanks for your
suggestions.


-- 
Jurjen Oskam

PGP Key available at http://www.stupendous.org/
