Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135463AbRD3P4c>; Mon, 30 Apr 2001 11:56:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135427AbRD3P4V>; Mon, 30 Apr 2001 11:56:21 -0400
Received: from relay.freedom.net ([207.107.115.209]:12299 "HELO relay")
	by vger.kernel.org with SMTP id <S135413AbRD3Pz4>;
	Mon, 30 Apr 2001 11:55:56 -0400
X-Freedom-Envelope-Sig: linux-kernel@vger.kernel.org AQHAkRjbtHLVD+Tjl8M/pWiWubc0UBoJzZruJzJcGflXfjzKQUr0gq6i
Date: Mon, 30 Apr 2001 09:55:25 -0600
Old-From: cacook@freedom.net
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Common GUI Config for All Users
Content-Type: text/plain; charset = "us-ascii" 
Content-Transfer-Encoding: 7bit
From: cacook@freedom.net
Message-Id: <20010430155605Z135413-409+1694@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Looking for the best way to give all users a common desktop, which comes from one source (for easy administration).

Found copying my /root/.gnome & .sawfish directories to a user home breaks the user's GUI, implying a symlink wouldn't work.  I am told .gnome & .sawfish can be copied to /etc/skel to give common look for new users, but need ongoing single-source control.  Besides, I tried copying root's config files to skel & it broke user GUIs.

Security is also a concern, so couldn't symlink into root anyway.

Symlinked root's panel file & folder to non-prived user's, but adding/removing an applet in root does not seem to affect the user's desktop.

Recommendations & resources welcomed, please.
--
C.

The best way out is always through.
      - Robert Frost  A Servant to Servants, 1914
