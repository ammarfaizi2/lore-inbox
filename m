Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311025AbSDMXbQ>; Sat, 13 Apr 2002 19:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSDMXbQ>; Sat, 13 Apr 2002 19:31:16 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:4088
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S311025AbSDMXbP>; Sat, 13 Apr 2002 19:31:15 -0400
Date: Sat, 13 Apr 2002 16:33:25 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Diego Calleja <DiegoCG@teleline.es>
Cc: linux-kernel@vger.kernel.org, Lionel.Bouton@inet6.fr, alan@redhat.com
Subject: Re: bug: Kernel timer added twice al c0198391 (2.4.19-pre5-ac3)
Message-ID: <20020413233325.GT23513@matchmail.com>
Mail-Followup-To: Diego Calleja <DiegoCG@teleline.es>,
	linux-kernel@vger.kernel.org, Lionel.Bouton@inet6.fr,
	alan@redhat.com
In-Reply-To: <20020413145455.638a8c40.DiegoCG@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 13, 2002 at 02:54:54PM +0200, Diego Calleja wrote:
> Kernel used: 2.4.19-pre5-ac3
> I have SiS 5513 IDE chipset
[snip]
> CONFIG_IDE_TASKFILE_IO=y

set this to "n".

Andre has mentioned a few times that he needs to send a new patch to Alan.
Until he does this, just disable this config option(recommended by Mr. Hedrick).

Mike
