Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262056AbUKJSg5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262056AbUKJSg5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 13:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbUKJSg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 13:36:57 -0500
Received: from rproxy.gmail.com ([64.233.170.206]:47995 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262056AbUKJSg4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 13:36:56 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=c7hcC3YRYLg2AAfusR8n++GxnGFYb3hLy8gcE6HlN6c3vN57IDm5mmWy4acYDcsyly0869EZMoCU6k9rn/FiH1BW0vtL+vQ6ixUQofFDU7dGwml6FoyTaw9HEJ5lhasz1pQ4nMv/6JF61C4u2Z7GSHOKOJyMUWmnRAE6YcZY6N4=
Message-ID: <fb20c214041110103647fc6b51@mail.gmail.com>
Date: Wed, 10 Nov 2004 12:36:56 -0600
From: Brian Jackson <notiggy@gmail.com>
Reply-To: Brian Jackson <notiggy@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6 vs 2.4: pxe booting system won't restart
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm having a problem with 2.6 (many versions), and my Via Epia M10000
not rebooting correctly. 2.4 works fine. The problem is after the
computer restarts, and the pxe stuff from the bios tries to do it's
thing, it fails. I get the following error:
PXE_M0F: Exiting Intel PXE ROM.

Then the bios tries to fallback to other means of booting, and there
are none. Anybody got any clues where to start looking for fixes?
