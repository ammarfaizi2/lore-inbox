Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263330AbTH0LbB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Aug 2003 07:31:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263331AbTH0LbA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Aug 2003 07:31:00 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:3532 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S263330AbTH0La6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Aug 2003 07:30:58 -0400
X-Sender-Authentication: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Wed, 27 Aug 2003 13:30:55 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Ville Herva <vherva@niksula.hut.fi>
Cc: linux-kernel@vger.kernel.org, tejun@aratech.co.kr
Subject: Re: 2.4.22pre8 hangs too (Re: 2.4.21-jam1 solid hangs)
Message-Id: <20030827133055.0f7aaf6e.skraw@ithnet.com>
In-Reply-To: <20030827110417.GY83336@niksula.cs.hut.fi>
References: <20030729073948.GD204266@niksula.cs.hut.fi>
	<20030730071321.GV150921@niksula.cs.hut.fi>
	<Pine.LNX.4.55L.0307301149550.29648@freak.distro.conectiva>
	<20030730181003.GC204962@niksula.cs.hut.fi>
	<20030827064301.GF150921@niksula.cs.hut.fi>
	<20030827110417.GY83336@niksula.cs.hut.fi>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Aug 2003 14:04:17 +0300
Ville Herva <vherva@niksula.hut.fi> wrote:

> > You're right, it looks pretty clean and simple. Possibly the only thing I
> > would try is moving aic away from int 9 to int 10 or so. Int 9 sometimes
> > interferes with VGA int routing on broken boxes. But that is unlikely
> > (though simple to test).
> 
> I don't think vga interferes with anything: I never run X on the box, and
> even the text console remains quiescent as nothing is logged.

The thing I ran into once was not really an intensive use of VGA and its ints
but rather some weird glitches in the boards' int logic that sometimes drove
the software drivers crazy (was network back then).

Regards,
Stephan
