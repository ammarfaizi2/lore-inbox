Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261387AbSJHRKi>; Tue, 8 Oct 2002 13:10:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261388AbSJHRKi>; Tue, 8 Oct 2002 13:10:38 -0400
Received: from [66.70.28.20] ([66.70.28.20]:33295 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S261387AbSJHRKh>; Tue, 8 Oct 2002 13:10:37 -0400
Date: Tue, 8 Oct 2002 19:14:43 +0200
From: DervishD <raul@pleyades.net>
To: Marc Giger <gigerstyle@gmx.ch>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dead processes
Message-ID: <20021008171443.GL45@DervishD>
References: <20021008184024.27c95217.gigerstyle@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20021008184024.27c95217.gigerstyle@gmx.ch>
User-Agent: Mutt/1.4i
Organization: Pleyades Net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Marc :))

    I almost forgot... A process become a zombie if it dies before
its parent, so the parent can retrieve child process status using
'wait()'. If the parent dies before doing this *then* the process
will be inherited by 'init' and ripped at some time.

    Seems like your gpg has died leaving a lot of children and 'init'
hasn't done its harvest yet ;))) Give it some time.

    Raúl
