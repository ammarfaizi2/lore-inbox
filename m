Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269438AbRHGVJA>; Tue, 7 Aug 2001 17:09:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269451AbRHGVIu>; Tue, 7 Aug 2001 17:08:50 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:956
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S269438AbRHGVIi>; Tue, 7 Aug 2001 17:08:38 -0400
Date: Tue, 7 Aug 2001 14:08:47 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@kobayashi.soze.net>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.x IP aliase max eth0:16 (16 aliases), where to change?
In-Reply-To: <20010807134830.B22821@mikef-linux.matchmail.com>
Message-ID: <Pine.LNX.4.33.0108071406100.17919-100000@kobayashi.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 7 Aug 2001, Mike Fedyk wrote:

> I would stop using the ifconfig aliases now, and start using the iproute
> (ip) command that was introduced with the 2.2 kernels.

Plus such aliases are much less ugly.  Deleting one will never delete all
others, and maintenence doesn't rely on knowing the alias number of a
particular ip address.

however, afaict, ip provides no way to force link type, and some other
link-layer settings also seem to be missing.


justin

