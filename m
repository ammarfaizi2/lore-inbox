Return-Path: <linux-kernel-owner+w=401wt.eu-S1752854AbWLOQZ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752854AbWLOQZ7 (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 11:25:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751543AbWLOQZ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 11:25:59 -0500
Received: from mo-p00-ob.rzone.de ([81.169.146.162]:53430 "EHLO
	mo-p00-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751547AbWLOQZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 11:25:58 -0500
X-Greylist: delayed 378 seconds by postgrey-1.27 at vger.kernel.org; Fri, 15 Dec 2006 11:25:57 EST
Date: Fri, 15 Dec 2006 17:19:37 +0100 (MET)
From: Oliver Neukum <oliver@neukum.name>
To: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: interface for modems with out of band signalling
User-Agent: KMail/1.9.1
Cc: Oliver Neukum <oliver@neukum.org>, linux-kernel@vger.kernel.org
References: <200612151514.00390.oliver@neukum.org>
 <4582C4FC.8040203@cfl.rr.com>
In-Reply-To: <4582C4FC.8040203@cfl.rr.com>
MIME-Version: 1.0
Content-Type: text/plain;  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612151709.48415.oliver@neukum.name>
X-RZG-AUTH: kN+qSWxTQH+Xqix8Cni7tCsVYhPCm1GP
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Freitag, 15. Dezember 2006 16:53 schrieb Phillip Susi:
> Oliver Neukum wrote:
> > Hi,
> > 
> > I have got a question about modems which use the AT command set, but
> > don't use in band signalling like true rs232 modems. Would two device nodes
> > per communication channel be a good interface?
> 
> Huh?  What do you mean "don't use in band signaling"?  If you are asking 
> how you issue AT commands to the modem while connected, you have to 
> break to command mode.  IIRC, this involves sending a special break 

No, I am talking about how to support modems which don't have a
command mode. These USB modems don't accept AT commands
through the same channel as data. They take them encapsulated in special
command messages to endpoint 0.
How do I export this capability to user space? I am thinking about having
two device nodes. But there may be a driver setting another precedent.
Therefor I am asking.

	Regards
		Oliver

