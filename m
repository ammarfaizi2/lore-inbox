Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264464AbTLVSHm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 13:07:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264467AbTLVSHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 13:07:42 -0500
Received: from smtp12.eresmas.com ([62.81.235.112]:14554 "EHLO
	smtp12.eresmas.com") by vger.kernel.org with ESMTP id S264464AbTLVSHl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 13:07:41 -0500
Message-ID: <3FE732A7.60402@wanadoo.es>
Date: Mon, 22 Dec 2003 19:06:31 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>, arnaud@andesi.org
Subject: Re: Oops with 2.4.23
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnaud Fontaine wrote:

> Sorry, i forgot to tell if i had error. So after 11 pass, i have had no
> error. I have also test with cpuburn which printed nothing after 30
> minutes.

disable the SWAP, and run three burnMMX for 30 minutes:

# swapoff -a
$ ./burnMMX P || echo $? &

