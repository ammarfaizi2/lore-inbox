Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265663AbUHCKs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265663AbUHCKs6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 06:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265684AbUHCKs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 06:48:58 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:54495
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S265663AbUHCKs4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 06:48:56 -0400
Message-ID: <410F6D96.60200@bio.ifi.lmu.de>
Date: Tue, 03 Aug 2004 12:48:54 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem: nfsd producing stales when restarting too fast
References: <410F69DF.7050602@bio.ifi.lmu.de> <16655.27452.741143.31043@cse.unsw.edu.au>
In-Reply-To: <16655.27452.741143.31043@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Brown wrote:

> Try doing the "exportfs -au"  *after* killing nfsd.
> Unexporting active filesystems while nfsd is running almost guarantees stale
> file handles.

Doesn't make a difference. Again, only a sleep (1 seems to be enough)
prevents the stale fs.

Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

