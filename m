Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264651AbTFYQlH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 12:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264653AbTFYQlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 12:41:07 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:10759 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264651AbTFYQlG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 12:41:06 -0400
Date: Wed, 25 Jun 2003 17:55:13 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mocm@mocm.de
Cc: Michael Hunold <hunold@convergence.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625175513.A28776@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mocm@mocm.de,
	Michael Hunold <hunold@convergence.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20030625150629.GA1045@mars.ravnborg.org> <20030625160830.A19958@infradead.org> <20030625154223.GB1333@mars.ravnborg.org> <3EF9CB25.4050105@convergence.de> <16121.53934.527440.109966@sheridan.metzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16121.53934.527440.109966@sheridan.metzler>; from mocm@metzlerbros.de on Wed, Jun 25, 2003 at 06:49:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 06:49:50PM +0200, Marcus Metzler wrote:
> You mean include/linux/dvb, I hope. Otherwise, it will break all user space
> applications.

No.  At least I hope he didn't mean it :)  Userspace has no _goddamn_
business to look at kernel headers.  Just stick a copy of those into
/usr/include/dvb/ for your applications that's in the dvb-dev or whatever
package.

