Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161185AbWALTIn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161185AbWALTIn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 14:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161188AbWALTIn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 14:08:43 -0500
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:39369 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1161185AbWALTIm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 14:08:42 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Orion Poplawski'" <orion@cora.nwra.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Help with machine check exception
Date: Thu, 12 Jan 2006 13:18:43 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYXoFLrlQT+6uYJRzqbqLnO/4i5CQADCdDg
In-Reply-To: <43C6974F.2080104@cora.nwra.com>
Message-ID: <EXCHG2003GR881Np7vX00000c0f@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 12 Jan 2006 19:02:18.0387 (UTC) FILETIME=[B5846630:01C617AA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> 
> I would have expected 2 CPU temps (being dual-processor).  
> Maybe Remote is the second.
> 
> With 4 copies of burnK7:
> 
> machine with problems:
> 
> CPU:      +71.25°C  (low  =   +10°C, high =   +50°C)     ALARM
> Board:    +47.25°C  (low  =   +10°C, high =   +35°C)     ALARM
> Remote:   +68.50°C  (low  =   +10°C, high =   +35°C)     ALARM
> 
> machine without:
> 
> CPU:      +61.25°C  (low  =   +10°C, high =   +50°C)     ALARM
> Board:    +47.25°C  (low  =   +10°C, high =   +35°C)     ALARM
> Remote:   +74.25°C  (low  =   +10°C, high =   +35°C)     ALARM
> 
> 
> So *maybe* cooling?
> 

That is a little on the warm side, I believe AMD's posted limit
is 70C for most of their chips, assuming the measuring point is
in the correct place for the 70C limit.

Certain cpus also seem to have more issues than others, so one cpu
out of a batch can be ok with a certain setup, and another from the
same batch will mce under similar conditions.

Did you build the machines yourself or did you buy them this way?

Machines getting MCE's that often will fail the burnin testing that
we use here.

And machines that produce those kinds of temps will also fail our
burn-in process just because that seems a bit too warm.

                           Roger

