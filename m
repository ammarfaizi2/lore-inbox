Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264768AbTFYRhg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 13:37:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264844AbTFYRhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 13:37:35 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:53255 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264768AbTFYRg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 13:36:27 -0400
Date: Wed, 25 Jun 2003 18:50:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mocm@mocm.de
Cc: Michael Hunold <hunold@convergence.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625185036.C29537@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mocm@mocm.de,
	Michael Hunold <hunold@convergence.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20030625160830.A19958@infradead.org> <20030625154223.GB1333@mars.ravnborg.org> <3EF9CB25.4050105@convergence.de> <16121.53934.527440.109966@sheridan.metzler> <20030625175513.A28776@infradead.org> <16121.55366.94360.338786@sheridan.metzler> <20030625181606.A29104@infradead.org> <16121.55873.675690.542574@sheridan.metzler> <20030625182409.A29252@infradead.org> <16121.56382.444838.485646@sheridan.metzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16121.56382.444838.485646@sheridan.metzler>; from mocm@metzlerbros.de on Wed, Jun 25, 2003 at 07:30:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 07:30:38PM +0200, Marcus Metzler wrote:
> Well, then you are wrong. You need those headers for user space
> applications and also for the kernel. The define the communication
> structures. If you put them into /usr/include you always risk having
> different versions of those structures. 

If the structures change incompatibly you're fucked anyway.  Better
have a copy in /usr/include that you can upgrade without updating libc
also, that way you can at least get the new structures / defines in time.

