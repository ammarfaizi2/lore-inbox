Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbULFT2a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbULFT2a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 14:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbULFT2a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 14:28:30 -0500
Received: from hermes.domdv.de ([193.102.202.1]:37639 "EHLO hermes.domdv.de")
	by vger.kernel.org with ESMTP id S261628AbULFT2W (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 14:28:22 -0500
Message-ID: <41B4B2CD.80209@domdv.de>
Date: Mon, 06 Dec 2004 20:28:13 +0100
From: Andreas Steinmetz <ast@domdv.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040918
X-Accept-Language: en-us, en, de
MIME-Version: 1.0
To: Ulrich Drepper <drepper@redhat.com>
CC: "Randy.Dunlap" <rddunlap@osdl.org>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
Subject: Re: host name length
References: <40521AA6.7070308@redhat.com> <20041203160538.77a22864.rddunlap@osdl.org> <Pine.LNX.4.53.0412060934450.11891@yvahk01.tjqt.qr> <41B48C9E.6030607@osdl.org> <41B49773.1010006@domdv.de> <41B4B210.1040105@redhat.com>
In-Reply-To: <41B4B210.1040105@redhat.com>
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper wrote:
> Yes, each label can only have 63 bytes, but the entire fqdn can be
> longer, much longer.  And the hostname stored with sethostname() should
> be the fqdn of the machine, not just one lalbel (in DNS speak).

255 characters to be exact. The question was, however, for the hostname 
which I usually don't interpret as a fqdn.
-- 
Andreas Steinmetz                       SPAMmers use robotrap@domdv.de
