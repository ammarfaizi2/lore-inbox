Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264496AbTFYOwU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 10:52:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264498AbTFYOwU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 10:52:20 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:5134 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S264496AbTFYOwT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 10:52:19 -0400
Date: Wed, 25 Jun 2003 17:06:29 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Michael Hunold <hunold@convergence.de>,
       Christoph Hellwig <hch@infradead.org>
Cc: linux-kernel@vger.kernel.org
Subject: DVB Include files
Message-ID: <20030625150629.GA1045@mars.ravnborg.org>
Mail-Followup-To: Michael Hunold <hunold@convergence.de>,
	Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael.

I can see that dvb has header files present in:
drivers/media/dvb/dvb-core

The usual rule is that header files used by others shall be
located in include/linux/..., in the dvb case is must be:
include/linux/media/dvb/

Any particular reason to keep them in the dvb-core dir?

hch: Please correct me if I got it wrong with respect to include files.

	Sam
