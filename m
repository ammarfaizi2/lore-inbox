Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131222AbRBVHV0>; Thu, 22 Feb 2001 02:21:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbRBVHVQ>; Thu, 22 Feb 2001 02:21:16 -0500
Received: from ganymede.isdn.uiuc.edu ([192.17.19.210]:31500 "EHLO
	ganymede.isdn.uiuc.edu") by vger.kernel.org with ESMTP
	id <S130144AbRBVHVD>; Thu, 22 Feb 2001 02:21:03 -0500
Date: Thu, 22 Feb 2001 01:20:57 -0600
From: Bill Wendling <wendling@ganymede.isdn.uiuc.edu>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <20010222012057.A13532@ganymede.isdn.uiuc.edu>
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz> <971ejs$139$1@cesium.transmeta.com> <20010221233204.A26671@atrey.karlin.mff.cuni.cz> <3A94435D.59A4D729@transmeta.com> <20010221235008.A27924@atrey.karlin.mff.cuni.cz> <3A94470C.2E54EB58@transmeta.com> <20010222000755.A29061@atrey.karlin.mff.cuni.cz> <3A944C05.FC2B623A@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3A944C05.FC2B623A@transmeta.com>; from hpa@transmeta.com on Wed, Feb 21, 2001 at 03:15:17PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Also sprach H. Peter Anvin:
} Martin Mares wrote:
} > 
} > Hello!
} > 
} > > True.  Note too, though, that on a filesystem (which we are, after all,
} > > talking about), if you assume a large linear space you have to create a
} > > file, which means you need to multiply the cost of all random-access
} > > operations with O(log n).
} > 
} > One could avoid this, but it would mean designing the whole filesystem in a
} > completely different way -- merge all directories to a single gigantic
} > hash table and use (directory ID,file name) as a key, but we were originally
} > talking about extending ext2, so such massive changes are out of question
} > and your log n access argument is right.
} > 
} 
} It would still be tricky since you have to have actual files in the
} filesystem as well.
} 
But that's just a user space issue, isn't it.

(Just kidding :-)

-- 
|| Bill Wendling			wendling@ganymede.isdn.uiuc.edu
