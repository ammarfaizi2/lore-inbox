Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261629AbTHZP7h (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbTHZP7h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:59:37 -0400
Received: from gw-nl5.philips.com ([212.153.235.109]:47238 "EHLO
	gw-nl5.philips.com") by vger.kernel.org with ESMTP id S261629AbTHZP7g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:59:36 -0400
Message-ID: <3F4B8434.80703@basmevissen.nl>
Date: Tue, 26 Aug 2003 18:00:52 +0200
From: Bas Mevissen <ml@basmevissen.nl>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: cijoml@volny.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test4 and /etc/modules.conf
References: <200308252332.46101.cijoml@volny.cz> <200308261428.07929.cijoml@volny.cz> <20030826123312.GD7038@fs.tum.de> <200308261748.20002.cijoml@volny.cz>
In-Reply-To: <200308261748.20002.cijoml@volny.cz>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Semler (volny.cz) wrote:

> Hi,
> 
> I have in /etc/modules.conf defined which modules to use. 2.4.22 uses it well, 
> but 2.6.0-test4 doesn't.
> 
> I tried add these defs into /etc/modprobe.d/aliases but without success.
> 

In 2.6, the file /etc/modprobe.conf is used. When you use Red Hat, you 
can install their modutils package from RawHide, that creates that file 
from your /etc/modules.conf file.

There is probably some util around that creates the file for you. This 
issue is documented in the FAQ in the modutils source.

 > When I by hand call for example modprobe hid module is loaded and
 > device works.

This means that you already got the proper modutils version installed.

Regards,

Bas.




