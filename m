Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272579AbTHEIQN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 04:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272587AbTHEIQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 04:16:12 -0400
Received: from tom.hrz.tu-chemnitz.de ([134.109.132.38]:27327 "EHLO
	tom.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id S272579AbTHEIQJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 04:16:09 -0400
Date: Tue, 5 Aug 2003 10:15:25 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alan Shih <alan@storlinksemi.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, Nivedita Singhvi <niv@us.ibm.com>,
       Werner Almesberger <werner@almesberger.net>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: TOE brain dump
Message-ID: <20030805101525.P670@nightmaster.csn.tu-chemnitz.de>
References: <20030804163606.Q639@nightmaster.csn.tu-chemnitz.de> <ODEIIOAOPGGCDIKEOPILEEOCDAAA.alan@storlinksemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <ODEIIOAOPGGCDIKEOPILEEOCDAAA.alan@storlinksemi.com>; from alan@storlinksemi.com on Mon, Aug 04, 2003 at 10:19:21AM -0700
X-Spam-Score: -4.5 (----)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19jwzG-00034j-00*RgAXBNAHfIU*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 10:19:21AM -0700, Alan Shih wrote:
> So would main processor still need a copy of the data for re-transmission?
> Won't that defeat the purpose?

No, since I didn't state that a retransmission is done along the
pipe, because you cannot go back in a pipeline.

A retransmission can be done at the end of the pipe, where this
can also be done in hardware.

Regards

Ingo Oeser

