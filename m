Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269390AbUINMfT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269390AbUINMfT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 08:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269418AbUINMeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 08:34:04 -0400
Received: from fbxmetz.linbox.com ([81.56.128.63]:57604 "EHLO xiii.metz")
	by vger.kernel.org with ESMTP id S269395AbUINMbV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 08:31:21 -0400
Message-ID: <4146E496.8050904@linbox.com>
Date: Tue, 14 Sep 2004 14:31:18 +0200
From: Ludovic Drolez <ludovic.drolez@linbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en, fr
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: keep the linux logo displayed on 2.6.7
References: <Pine.LNX.4.44.0307211749400.6905-100000@phoenix.infradead.org>
In-Reply-To: <Pine.LNX.4.44.0307211749400.6905-100000@phoenix.infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

One year ago, I wanted to find a way to keep the linux logo displayed, and I 
posted this:

Many thanks for the esc sequence hint !
But it seems there's something broken with it: if I send 'esc[10;20r'
- the scrolling region is now between lines 10 and 20
- but, the cursor is moved to 0,0 instead of line 10
- and the linux logo does not appear...
Bug or feature ??

James Simmons said 'Bug. Fixed in the latest kernel.', but with a 2.6.7, the 
escape sequence has the same behavior and the logo does not appear. (cursor 
moved to 0,0 instead of line 10).

Any ideas on how to really fix that bug ?

Cheers,

-- 
Ludovic DROLEZ                                       Free&ALter Soft
152, rue de Grigy - Technopole Metz 2000                  57070 METZ
tel : 03 87 75 55 21                            fax : 03 87 75 19 26


