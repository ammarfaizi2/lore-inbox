Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWDMQ7b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWDMQ7b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 12:59:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbWDMQ7b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 12:59:31 -0400
Received: from web88009.mail.re2.yahoo.com ([206.190.37.196]:57943 "HELO
	web88009.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751099AbWDMQ7a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 12:59:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=rogers.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=y0OwubjK3bt55BE66H75lqWgkQmdvrRgE7Kdy8nFfvImvrVBVWVbdxjutL/BX00VBGHxuU/jTvj5LmG9eMyCCoayHe/N+vXuBIbry7OgNjDYNwyfwso4KqULTlv+SJr3G/lPMUWSc+FInBdPH6OgfWJ7bSAXV7HjZxLSFVWqH8E=  ;
Message-ID: <20060413165929.95476.qmail@web88009.mail.re2.yahoo.com>
Date: Thu, 13 Apr 2006 12:59:29 -0400 (EDT)
From: Dwh <wrsdwh@rogers.com>
Subject: Mpc8xx in 2.6.10/ppc
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Has anyone ever used this driver to talk to a Sandisk
compact flash card running in true ide mode from a
big-endian host(ppc)?  Did you need to configure the
IDE disk driver as well? 

I'm getting a DRQ (Data request) error on every block
transfer from the device.  I've had to modify swap
bytes when doing the data read and make many other
changes just to get some life out of the card.

Please cc me personally as I'm not a subscriber...

dwh
