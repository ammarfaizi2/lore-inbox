Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751357AbWJMPuh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751357AbWJMPuh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 11:50:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751339AbWJMPuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 11:50:37 -0400
Received: from mx1.redhat.com ([66.187.233.31]:29076 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751357AbWJMPug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 11:50:36 -0400
Date: Fri, 13 Oct 2006 11:50:20 -0400
From: Dave Jones <davej@redhat.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: Burman Yan <yan_952@hotmail.com>, linux-kernel@vger.kernel.org,
       Andrey Panin <pazke@donpac.ru>
Subject: Re: [PATCH] HP mobile data protection system driver
Message-ID: <20061013155020.GA8204@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Jesper Juhl <jesper.juhl@gmail.com>,
	Burman Yan <yan_952@hotmail.com>, linux-kernel@vger.kernel.org,
	Andrey Panin <pazke@donpac.ru>
References: <BAY20-F7ACD05600A29690DC3CCED80A0@phx.gbl> <20061013092603.GA26306@pazke.donpac.ru> <9a8748490610130306v3bfe13b4j135cc474ff718657@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490610130306v3bfe13b4j135cc474ff718657@mail.gmail.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2006 at 12:06:40PM +0200, Jesper Juhl wrote:

 > > +          accelerometer data is readable via /proc/drivers/mdps.
 > 
 > I believe it would be better to use sysfs. Procfs is cluttered enough
 > as it is and there's not much will to clutter it further.

Better yet, would be to use the same interface the hdaps driver uses
so that userspace written for one accelerometer works with any hardware.
Having to cope with a dozen different drivers who export in different
places is just silly.

	Dave

-- 
http://www.codemonkey.org.uk
